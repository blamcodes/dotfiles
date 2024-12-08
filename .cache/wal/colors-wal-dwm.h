static const char norm_fg[] = "#dfc7d9";
static const char norm_bg[] = "#0B0A13";
static const char norm_border[] = "#9c8b97";

static const char sel_fg[] = "#dfc7d9";
static const char sel_bg[] = "#60388A";
static const char sel_border[] = "#dfc7d9";

static const char urg_fg[] = "#dfc7d9";
static const char urg_bg[] = "#87607A";
static const char urg_border[] = "#87607A";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
