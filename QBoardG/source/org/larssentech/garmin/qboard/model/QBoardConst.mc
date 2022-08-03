/*
MIT License

Copyright (c) 2022 Lars Andersson (software@larssentech.org)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

Author: Lars Andersson (GitHub: Larssentech (https://github.com/Larssentech/garmin.git);
License: MIT License
*/

using Toybox.System as System;
using Toybox.Graphics as Gfx;

class QBoardConst {

    static const VERSION = "0.1.0";

    // This is the desired keyboard layout ==================================================
    static const QBOARD_CHARACTERS = "1234567890QWERTYUIOPASDFGHJKL'@ZXCVBNM,.<>=?!$()-+";  // QWERTY X (!!) characters for input
    // ======================================================================================

    // Strings
    static const TITLE = "QBøard";
    static const SUBTITLE_1 = "Press ENTER";
    static const SUBTITLE_2 = "to start typing...";
    static const CURSOR = " ";
    static const QB_VIEW_TITLE = "QBøard";
    static const MADE_BY = "QBøard by Larssentech Labs (2022)";
    static const VERSION_S = "Version " + VERSION;
    static const SPACE = " ";
    static const EMPTY = "";
    static const NEW_LINE = "\n";

    // Numbers
    static const QBOARD_IX_MAX = QBOARD_CHARACTERS.length();
    static const QBOARD_ROWS = 5;
    static const QBOARD_COLS = 10; // ROWS x COLS must = QBOARD_CHARACTERS length (!!!)
    
    static const QBOARD_AREA_X = 1f;
    static const QBOARD_AREA_Y = 0.325f;
    
    static const DEVICE_HEIGHT0 = System.getDeviceSettings().screenHeight;
    static const DEVICE_WIDTH0 = System.getDeviceSettings().screenWidth;

    static const QBOARD_COL_W = DEVICE_WIDTH0/QBOARD_COLS;
    static const QBOARD_ROW_H = (DEVICE_HEIGHT0*QBOARD_AREA_Y)/QBOARD_ROWS;

    static const QBOARD_START_X = DEVICE_WIDTH0*(1-QBOARD_AREA_X);
    static const QBOARD_END_X = QBOARD_START_X+(QBOARD_COL_W*QBOARD_COLS);
    
    static const QBOARD_START_Y = DEVICE_HEIGHT0*(1-QBOARD_AREA_Y);
    static const QBOARD_END_Y = QBOARD_START_Y+(QBOARD_ROW_H*QBOARD_ROWS);

    static const TEXT_POSITION_X = 10;
    static const TEXT_POSITION_Y = (DEVICE_HEIGHT0-QBOARD_START_Y)/2;

    static const QPAD_MARGIN_LEFT = 10;
    static const QPAD_MARGIN_RIGHT = 10;
    static const QPAD_MARGIN_TOP = 10;
    static const QPAD_MARGIN_BOTTOM = 10;

    static const QPAD_ROWS = 7;
    static const QPAD_X = 0;
    static const QPAD_Y = 40;
    static const QPAD_W = DEVICE_WIDTH0;
    static const QPAD_H = QPAD_ROWS*QBOARD_ROW_H;
    
    // Fonts
    static const FNT_STD = Gfx.FONT_MEDIUM;

    // Colours
    // Theme
    static const CLR_THEME_GREEN = Gfx.COLOR_DK_GREEN;
    static const CLR_TRANSPARENT = Gfx.COLOR_TRANSPARENT;

    // "Front" view
    static const CLR_FRONT_BG = Gfx.COLOR_BLACK;
    static const CLR_FRONT_TITLE = Gfx.COLOR_DK_GREEN;
    static const CLR_FRONT_TEXT = Gfx.COLOR_WHITE;
    static const CLR_FRONT_MADE_BY = Gfx.COLOR_LT_GRAY;
    static const CLR_FRONT_VERSION = Gfx.COLOR_DK_GRAY;

    // QBoard view
    static const CLR_QBOARD_BG = Gfx.COLOR_BLACK;
    static const CLR_QBOARD_TITLE = Gfx.COLOR_DK_GREEN;

    // QPad
    static const CLR_QPAD_BORDER = Gfx.COLOR_DK_GRAY;
    static const CLR_QPAD_BG = Gfx.COLOR_TRANSPARENT;
    static const CLR_QPAD_TEXT = Gfx.COLOR_WHITE;
    static const CLR_QPAD_CURSOR = Gfx.COLOR_DK_GREEN;
    static const CLR_QPAD_CURSED_TEXT = Gfx.COLOR_BLACK;
    static const CLR_QPAD_CURSED_TEXT_BG = Gfx.COLOR_DK_GREEN;
    static const CLR_QPAD_EDIT_TEXT_BG = Gfx.COLOR_RED;
    
    // QB grid and chars
    static const CLR_QB_CHARS = Gfx.COLOR_LT_GRAY;
    static const CLR_QB_CHARS_BG = Gfx.COLOR_TRANSPARENT;
    static const CLR_QB_GRID = Gfx.COLOR_DK_GRAY;

    // QBox
    static const CRL_QBOX_ACTIVE = Gfx.COLOR_DK_GREEN;
    static const CRL_QBOX_INACTIVE = Gfx.COLOR_DK_GRAY;

}