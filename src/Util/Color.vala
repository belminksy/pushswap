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

    public class Color {

        private static double[] BOUNDS = null;

        public double red;
        public double green;
        public double blue;


        public Color(double red, double green, double blue) {
            this.red = red;
            this.green = green;
            this.blue = blue;
        }


        public static Color from_decimal(int dec) {

            /* for some strange reason, static arrays are not initialized
               before the first call of a static method */
            if (Color.BOUNDS == null) {

                Color.BOUNDS = new double[] {
                    0,
                    16666,
                    33333,
                    50000,
                    66666,
                    83333,
                    100000
                };

            }

            return new Color(
                extract_red_from_decimal(dec),
                extract_green_from_decimal(dec),
                extract_blue_from_decimal(dec)
            );

        }


        private static double extract_red_from_decimal(int dec) {

            if (Color.BOUNDS[5] <= dec || dec <= Color.BOUNDS[1]) {
                return 1;
            }

            if (Color.BOUNDS[1] < dec && dec < Color.BOUNDS[2]) {
                return (Color.BOUNDS[2] - dec) / Color.BOUNDS[1];
            }

            if (Color.BOUNDS[4] < dec && dec < Color.BOUNDS[5]) {
                return 1 + (dec - Color.BOUNDS[5]) / Color.BOUNDS[1];
            }

            return 0;
        }

        private static double extract_green_from_decimal(int dec) {

            if (Color.BOUNDS[1] <= dec && dec <= Color.BOUNDS[3]) {
                return 1;
            }

            if (Color.BOUNDS[3] < dec && dec < Color.BOUNDS[4]) {
                return (Color.BOUNDS[4] - dec) / Color.BOUNDS[1];
            }

            if (Color.BOUNDS[0] < dec && dec < Color.BOUNDS[1]) {
                return 1 + (dec - Color.BOUNDS[1]) / Color.BOUNDS[1];
            }

            return 0;
        }

        private static double extract_blue_from_decimal(int dec) {

            if (Color.BOUNDS[3] <= dec && dec <= Color.BOUNDS[5]) {
                return 1;
            }

            if (Color.BOUNDS[5] < dec && dec < Color.BOUNDS[6]) {
                return (Color.BOUNDS[6] - dec) / Color.BOUNDS[1];
            }

            if (Color.BOUNDS[2] < dec && dec < Color.BOUNDS[3]) {
                return 1 + (dec - Color.BOUNDS[3]) / Color.BOUNDS[1];
            }

            return 0;
        }

    }

}
