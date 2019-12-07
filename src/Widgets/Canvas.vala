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

using GLib.Math;

namespace PushChroma.Widgets {

    public class Canvas : Gtk.DrawingArea {

        public Canvas() {

            this.draw.connect(on_draw);

        }

        public void refresh() {
            queue_draw_area(0, 0, get_allocated_width(), get_allocated_height());
        }

        private bool on_draw(Gtk.Widget widget, Cairo.Context ctx) {


            ctx.set_line_width (30 / 4);
            ctx.set_tolerance (0.1);

            int width = widget.get_allocated_width();
            int height = widget.get_allocated_height();

            int x = width / 2;
            int y = height / 2;

            int radius = (width / 2) - 20;

            if (width > height)
                radius = (height / 2) - 20;


            double max = 100;
            double[] bounds = new double[] {
                (max / 6) * 1,
                (max / 6) * 2,
                (max / 6) * 3,
                (max / 6) * 4,
                (max / 6) * 5,
                (max / 6) * 6,
            };

            double ratio = max / (2 * Math.PI);

            for (double i = 0; i < max; i++) {

                double r = get_red(i, bounds);
                double g = get_green(i, bounds);
                double b = get_blue(i, bounds);

                ctx.set_source_rgb ( r, g, b );

                double begin_x = Math.cos(i / ratio) * radius;
                double begin_y = Math.sin(i / ratio) * radius;
                double end_x = Math.cos((i + 1) / ratio) * radius;
                double end_y = Math.sin((i + 1) / ratio) * radius;

                ctx.new_path();
                ctx.move_to(x, y);
                ctx.line_to(x + begin_x, y + begin_y);
                ctx.line_to(x + end_x, y + end_y);
                ctx.close_path ();
                ctx.fill();

            }

            return true;
        }


        double get_red(double pos, double[] bounds) {

            if (bounds[4] <= pos || pos <= bounds[0]) {
                return 1;
            }

            if (bounds[0] < pos && pos < bounds[1]) {
                return (bounds[1] - pos) / bounds[0];
            }

            if (bounds[3] < pos && pos < bounds[4]) {
                return 1 + (pos - bounds[4]) / bounds[0];
            }

            return 0;
        }

        double get_green(double pos, double[] bounds) {

            if (bounds[0] <= pos && pos <= bounds[2]) {
                return 1;
            }

            if (bounds[2] < pos && pos < bounds[3]) {
                return (bounds[3] - pos) / bounds[0];
            }

            if (0 < pos && pos < bounds[0]) {
                return 1 + (pos - bounds[0]) / bounds[0];
            }

            return 0;
        }

        double get_blue(double pos, double[] bounds) {

            if (bounds[2] <= pos && pos <= bounds[4]) {
                return 1;
            }

            if (bounds[4] < pos && pos < bounds[5]) {
                return (bounds[5] - pos) / bounds[0];
            }

            if (bounds[1] < pos && pos < bounds[2]) {
                return 1 + (pos - bounds[2]) / bounds[0];
            }

            return 0;
        }

    }

}
