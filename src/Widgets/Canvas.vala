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
using PushChroma.Util;
using PushChroma.Pushswap;

namespace PushChroma.Widgets {

    protected DoublyCircularLinkedList list_a = null;
    protected DoublyCircularLinkedList list_b = null;

    protected int size = 0;


    public class Canvas : Gtk.DrawingArea {

        public Canvas() {
            this.draw.connect(on_draw);
        }


        public void initialize(Interpreter interpreter) {

            list_a = interpreter.list_a;
            list_b = interpreter.list_b;

            size = interpreter.nb_scanner.size;

        }


        public void refresh() {
            queue_draw_area(0, 0, get_allocated_width(), get_allocated_height());
        }

        private bool on_draw(Gtk.Widget widget, Cairo.Context ctx) {

            if (list_a == null || list_b == null)
                return true;


            ctx.set_line_width (30 / 4);
            ctx.set_tolerance (0.1);

            int width = widget.get_allocated_width();
            int height = widget.get_allocated_height();

            int x = width / 2;
            int y = height / 2;

            int radius = (width / 2) - 20;

            if (width > height)
                radius = (height / 2) - 20;


            double ratio = size / (2 * Math.PI);

            PushChroma.Util.Node head = list_a.get_head();
            PushChroma.Util.Node node = head.next;
            int index = 0;

            while (node != head) {

                double r = node.color.red;
                double g = node.color.green;
                double b = node.color.blue;

                ctx.set_source_rgb(r, g, b);


                double begin_x = Math.cos(index / ratio) * radius;
                double begin_y = Math.sin(index / ratio) * radius;
                double end_x = Math.cos((index + 1) / ratio) * radius;
                double end_y = Math.sin((index + 1) / ratio) * radius;

                ctx.new_path();
                ctx.move_to(x, y);
                ctx.line_to(x + begin_x, y + begin_y);
                ctx.line_to(x + end_x, y + end_y);
                ctx.close_path ();
                ctx.fill();

                index++;
                node = node.next;
            }


            head = list_b.get_head();
            node = head.next;

            while (node != head) {

                double r = node.color.red;
                double g = node.color.green;
                double b = node.color.blue;

                ctx.set_source_rgb(r, g, b);


                double begin_x = Math.cos(index / ratio) * radius;
                double begin_y = Math.sin(index / ratio) * radius;
                double end_x = Math.cos((index + 1) / ratio) * radius;
                double end_y = Math.sin((index + 1) / ratio) * radius;

                ctx.new_path();
                ctx.move_to(x, y);
                ctx.line_to(x + begin_x, y + begin_y);
                ctx.line_to(x + end_x, y + end_y);
                ctx.close_path ();
                ctx.fill();

                index++;
                node = node.next;
            }

            return true;
        }

    }

}
