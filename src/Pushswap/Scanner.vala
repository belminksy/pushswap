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

namespace PushChroma.Pushswap {

    public abstract class Scanner {

        private File file;


        public Scanner(File file) {
            this.file = file;
        }

        protected string read_file() {

            if (!file.query_exists()) {
                return "";
            }

            var input = new StringBuilder();

            try {

                var input_stream = new DataInputStream(file.read());

                string line;
                while ((line = input_stream.read_line(null)) != null) {
                    input.append(line);
                }


            } catch (Error e) {
                return "";
            }

            return input.str;

        }

    }

}
