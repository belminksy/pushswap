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

namespace PushChroma.Util {

    public class DoublyCircularLinkedList {

        protected Node head = null;


        public DoublyCircularLinkedList() {

            head = new Node(0);

            head.next = head;
            head.prev = head;

        }


        public void push(int data) {

            var elem = new Node(data);

            elem.next = head;
            elem.prev = head.prev;

            head.prev.next = elem;
            head.prev = elem;

        }


        public void swap() {

            var tmp1 = head.next.data;
            var tmp2 = head.next.color;

            /* Sets data of the first element */
            head.next.data = head.next.next.data;
            head.next.color = head.next.next.color;

            /* Sets data of the second element */
            head.next.next.data = tmp1;
            head.next.next.color = tmp2;

        }

        public void rotate() {

            var tmp = head.next;

            /* Removes the first element */
            head.next.next.prev = head;
            head.next = head.next.next;

            /* Sets new values of the former first */
            tmp.prev = head.prev;
            tmp.next = head;

            /* Inserts the former first at the end */
            head.prev.next = tmp;
            head.prev = tmp;

        }

        public void take_head(DoublyCircularLinkedList list) {

            if (list.head.next == list.head)
                return;

            var tmp = list.head.next;

            /* Removes the first element of the argument */
            list.head.next.next.prev = list.head;
            list.head.next = list.head.next.next;

            /* Sets new values of the taken node */
            tmp.next = head.next;
            tmp.prev = head;

            /* Inserts the taken node at the end */
            head.next.prev = tmp;
            head.next = tmp;

        }


        public Node get_head() {
            return head;
        }

    }

}
