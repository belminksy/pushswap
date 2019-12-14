/*
 * MIT License
 *
 * Copyright (c) 2019 Adrien Belminksy
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

using PushChroma.Widgets;
using PushChroma.Pushswap;

namespace PushChroma {

    public class PushChromaApp : Gtk.Application {

        protected Gtk.ApplicationWindow window = null;
        protected Canvas canvas = null;

        protected MainLoop update_loop = null;
        protected MainLoop render_loop = null;

        protected Interpreter interpreter = null;

        protected bool running = false;
        protected bool playing = false;

        public override void activate() {

            window = new Gtk.ApplicationWindow(this);
            add_window(window);

            window.title = Config.WINDOW_TITLE;
            window.set_default_size(Config.WINDOW_WIDTH, Config.WINDOW_HEIGHT);

            canvas = new PushChroma.Widgets.Canvas();
            window.add(canvas);

            window.show_all();

            init();
            start();
            loop();

        }

        public void init() {

            var quit_action = new SimpleAction("quit", null);

            add_action(quit_action);

            set_accels_for_action("app.quit", { "<Control>q" });

            quit_action.activate.connect(stop);
            window.destroy.connect(stop);


            var op_scanner = new OperationScanner(File.new_for_path("actions"));
            var nb_scanner = new NumberScanner(File.new_for_path("numbers"));

            interpreter = new Interpreter(op_scanner, nb_scanner);

            canvas.initialize(interpreter);

        }

        public void start() {

            running = true;
            playing = true;

        }

        public void play() {

            playing = true;

        }

        public void pause() {

            playing = false;

        }

        public void stop() {

            running = false;
            playing = false;

            if (update_loop != null)
                update_loop.quit();

            if (render_loop != null)
                render_loop.quit();

            exit();

        }

        public void exit() {

            window.destroy();

        }

        public void loop() {

            update_loop = new MainLoop();
            render_loop = new MainLoop();

            var ticks = new TimeoutSource(1000 / Config.TPS);
            var frames = new TimeoutSource(1000 / Config.FPS);

            ticks.set_callback(() => {

                if (!running) {
                    update_loop.quit();
                    return false;
                }

                if (!playing)
                    return true;

                update();

                return true;

            });

            frames.set_callback(() => {

                if (!running) {
                    render_loop.quit();
                    return false;
                }

                render();

                return true;

            });

            ticks.attach(update_loop.get_context());
            frames.attach(render_loop.get_context());

            update_loop.run();
            render_loop.run();

        }

        public void update() {

            if (!playing)
                return;

            if (interpreter == null || interpreter.isFinished())
                return;

            interpreter.next();

        }

        public void render() {

            canvas.refresh();

        }

    }

}
