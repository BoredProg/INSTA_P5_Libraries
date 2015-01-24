//////////////////////////////////////////////////////////
// Robert Penner's ActionScript easing equations ported //
//   to Java.                                           //
//   by David Grant <x&seizethedave'com>                //
//                                                      //
// See: http://www.robertpenner.com/easing/             //
//////////////////////////////////////////////////////////

Based on Penner's 1.5 Actionscript source code.

-> TO USE WITH PROCESSING:

There is an easing.jar file in the zip file.  Place
easing.jar in your sketch's \code folder.  The static
easing methods will then be usable from processing like so:

void loop ()
{
    PennerEasing.EaseInQuad(a, b, c, d);
}


--
Easing Equations (c) 2003 Robert Penner, all rights reserved.
This work is subject to the terms in
http://www.robertpenner.com/easing_terms_of_use.html.
--
