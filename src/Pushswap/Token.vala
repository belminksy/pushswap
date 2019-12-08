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

    public enum TokenType {
        /*
        SA, // swap the first two elements of list_a
        SB, // swap the first two elements of list_b
        SC, // sa and sb at the same time
        */
        PA, // take the first element from list_b and move it to the first position on the list_a
        PB, // take the first element from list_a and move it to the first position on the list_b
        RA, // rotate list_a toward the beginning, the first element will become the last
        RB, // rotate list_b toward the beginning, the first element will become the last
        RR, // rr and rb at the same time
        /*
        RRA, // rotate list_a toward the end, the last element will become the first
        RRB, // rotate list_b toward the end, the last element will become the first
        RRR, // rra and rrb at the same time
        */
        WHITESPACE
    }

    public class Token {

        public string content;
        public TokenType type;


        public Token(string content, TokenType type) {
            this.content = content;
            this.type = type;
        }

    }

}
