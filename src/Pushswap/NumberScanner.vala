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

    public class NumberScanner : Scanner {

        private int pos = 0;
        private int _size = 0;


        public NumberScanner(File file) {
            base(file);
        }


        public DoublyCircularLinkedList? scan() {

            string input = read_file();

            if (input.length == 0)
                return null;

            var list = new DoublyCircularLinkedList();

            pos = 0;
            Token token;

            while ((token = get_next_token(input)) != null) {

                if (token.type == TokenType.WHITESPACE)
                    continue;

                list.push(int.parse(token.content));
                _size++;

            }

            return list;
        }

        private Token? get_next_token(string input) {

            int start = pos;

            if (input[pos] == ' ') {
                while (input[pos] == ' ') {
                    pos++;
                }

                return new Token(" ", TokenType.WHITESPACE);
            }


            while ('0' <= input[pos] && input[pos] <= '9') {
                pos++;
            }

            if (start == pos)
                return null;

            var content = input.substring(start, pos - start);

            return new Token(content, TokenType.NUMBER);
        }


        public int size {
            public get { return _size; }
        }

    }

}
