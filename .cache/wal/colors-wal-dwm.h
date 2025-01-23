static const char norm_fg[] = "#acb5ba";
static const char norm_bg[] = "#070710";
static const char norm_border[] = "#787e82";

static const char sel_fg[] = "#acb5ba";
static const char sel_bg[] = "#9C3F4E";
static const char sel_border[] = "#acb5ba";

static const char urg_fg[] = "#acb5ba";
static const char urg_bg[] = "#5D5C6B";
static const char urg_border[] = "#5D5C6B";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
