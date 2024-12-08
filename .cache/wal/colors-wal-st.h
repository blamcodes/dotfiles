const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#0B0A13", /* black   */
  [1] = "#87607A", /* red     */
  [2] = "#60388A", /* green   */
  [3] = "#6D5292", /* yellow  */
  [4] = "#9E6297", /* blue    */
  [5] = "#B459B3", /* magenta */
  [6] = "#7D83BF", /* cyan    */
  [7] = "#dfc7d9", /* white   */

  /* 8 bright colors */
  [8]  = "#9c8b97",  /* black   */
  [9]  = "#87607A",  /* red     */
  [10] = "#60388A", /* green   */
  [11] = "#6D5292", /* yellow  */
  [12] = "#9E6297", /* blue    */
  [13] = "#B459B3", /* magenta */
  [14] = "#7D83BF", /* cyan    */
  [15] = "#dfc7d9", /* white   */

  /* special colors */
  [256] = "#0B0A13", /* background */
  [257] = "#dfc7d9", /* foreground */
  [258] = "#dfc7d9",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
