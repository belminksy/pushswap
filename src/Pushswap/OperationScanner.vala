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

    public class OperationScanner : Scanner {

        private int pos = 0;


        public OperationScanner(File file) {
            base(file);
        }


        public List<Token>? scan() {

            string input = read_file();

            if (input.length == 0)
                return null;

            List<Token> tokens = new List<Token>();

            pos = 0;
            Token token;

            while ((token = get_next_token(input)) != null) {

                if (token.type == TokenType.WHITESPACE)
                    continue;

                tokens.append(token);

            }

            return tokens;
        }

        private Token? get_next_token(string input) {

            int start = pos;
            TokenType type;

            if (input[pos] == ' ') {
                while (input[pos] == ' ') {
                    pos++;
                }

                return new Token(" ", TokenType.WHITESPACE);
            }


            while ('a' <= input[pos] && input[pos] <= 'z') {
                pos++;
            }

            if (start == pos)
                return null;

            var content = input.substring(start, pos - start);

            switch (content) {

                case "pa":
                    type = TokenType.PA;
                    break;

                case "pb":
                    type = TokenType.PB;
                    break;

                case "ra":
                    type = TokenType.RA;
                    break;

                case "rb":
                    type = TokenType.RB;
                    break;

                case "rr":
                    type = TokenType.RR;
                    break;

                default:
                    stderr.printf("Error: unknown operation (%s), abort!\n", content);
                    return null;

            }

            return new Token(content, type);
        }

    }

}
