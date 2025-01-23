const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#070710", /* black   */
  [1] = "#5D5C6B", /* red     */
  [2] = "#9C3F4E", /* green   */
  [3] = "#9A5E66", /* yellow  */
  [4] = "#E66055", /* blue    */
  [5] = "#F59A58", /* magenta */
  [6] = "#E9C964", /* cyan    */
  [7] = "#acb5ba", /* white   */

  /* 8 bright colors */
  [8]  = "#787e82",  /* black   */
  [9]  = "#5D5C6B",  /* red     */
  [10] = "#9C3F4E", /* green   */
  [11] = "#9A5E66", /* yellow  */
  [12] = "#E66055", /* blue    */
  [13] = "#F59A58", /* magenta */
  [14] = "#E9C964", /* cyan    */
  [15] = "#acb5ba", /* white   */

  /* special colors */
  [256] = "#070710", /* background */
  [257] = "#acb5ba", /* foreground */
  [258] = "#acb5ba",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
