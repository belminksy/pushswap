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

using PushChroma.Util;

namespace PushChroma.Pushswap {

    public class Interpreter {

        protected List<Token>? tokens;

        public DoublyCircularLinkedList list_a;
        public DoublyCircularLinkedList list_b;

        protected int index = 0;


        public Interpreter(Parser parser, DoublyCircularLinkedList list) {

            tokens = parser.parse();

            list_a = list;
            list_b = new DoublyCircularLinkedList();

        }


        public bool next() {

            if (tokens == null)
                return false;

            if (isFinished())
                return false;

            unowned Token? token = tokens.nth_data(index++);

            if (token == null)
                return false;

            execute(token);

            return true;

        }

        private void execute(Token token) {

            switch (token.type) {

                case TokenType.PA:
                    list_a.take_head(list_b);
                    break;

                case TokenType.PB:
                    list_b.take_head(list_a);
                    break;

                case TokenType.RA:
                    list_a.rotate();
                    break;

                case TokenType.RB:
                    list_b.rotate();
                    break;

                case TokenType.RR:
                    list_a.rotate();
                    list_b.rotate();
                    break;

            }

        }


        public bool isFinished() {

            if (tokens == null)
                return true;

            return index == tokens.length();
        }

    }

}
