public class PennerEasing
{
    //////////////////////////////////////////////////////////
    // Robert Penner's ActionScript easing equations ported //
    //   to Java with permission                            //
    //   by David Grant <x&seizethedave'com>                //
    //                                                      //
    // See: http://www.robertpenner.com/easing/             //
    //////////////////////////////////////////////////////////
    
    /*
    Easing Equations v1.5
    May 1, 2003
    (c) 2003 Robert Penner, all rights reserved. 
    This work is subject to the terms in http://www.robertpenner.com/easing_terms_of_use.html.  
  
    These tweening functions provide different flavors of 
    math-based motion under a consistent API. 
  
    Types of easing:
  
        Linear
        Quadratic
        Cubic
        Quartic
        Quintic
        Sinusoidal
        Exponential
        Circular
        Elastic
        Back
        Bounce

    Changes:
    1.5 - added bounce easing
    1.4 - added elastic and back easing
    1.3 - tweaked the exponential easing functions to make endpoints exact
    1.2 - inline optimizations (changing t and multiplying in one step)--thanks to Tatsuo Kato for the idea
  
    Discussed in Chapter 7 of 
    Robert Penner's Programming Macromedia Flash MX
    (including graphs of the easing equations)
  
    http://www.robertpenner.com/profmx
    http://www.amazon.com/exec/obidos/ASIN/0072223561/robertpennerc-20
    */

    ///////////// QUADRATIC EASING: t^2 ///////////////////

    // quadratic easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in value, d: duration
    // t and d can be in frames or seconds/milliseconds
   
    public static double EaseInQuad (double t, double b, double c, double d)
    {
        return c*(t/=d)*t+b;
    }

    // quadratic easing out - decelerating to zero velocity
    public static double EaseOutQuad (double t, double b, double c, double d)
    {
        return -c *(t/=d)*(t-2) + b;
    }

    // quadratic easing in/out - acceleration until halfway, then deceleration
    public static double EaseInOutQuad (double t, double b, double c, double d)
    {
        if ((t/=d/2) < 1) return c/2*t*t + b;
        return -c/2 * ((--t)*(t-2) - 1) + b;
    }


    ///////////// CUBIC EASING: t^3 ///////////////////////

    // cubic easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in value, d: duration
    // t and d can be frames or seconds/milliseconds
    public static double EaseInCubic (double t, double b, double c, double d)
    {
        return c*(t/=d)*t*t + b;
    }

    // cubic easing out - decelerating to zero velocity
    public static double EaseOutCubic (double t, double b, double c, double d)
    {
        return c*((t=t/d-1)*t*t + 1) + b;
    }

    // cubic easing in/out - acceleration until halfway, then deceleration
    public static double EaseInOutCubic (double t, double b, double c, double d)
    {
        if ((t/=d/2) < 1)
            return c/2*t*t*t + b;
        return c/2*((t-=2)*t*t + 2) + b;
    }


    ///////////// QUARTIC EASING: t^4 /////////////////////

    // quartic easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in value, d: duration
    // t and d can be frames or seconds/milliseconds
    public static double EaseInQuart (double t, double b, double c, double d)
    {
        return c*(t/=d)*t*t*t + b;
    }

    // quartic easing out - decelerating to zero velocity
    public static double EaseOutQuart (double t, double b, double c, double d)
    {
        return -c * ((t=t/d-1)*t*t*t - 1) + b;
    }

    // quartic easing in/out - acceleration until halfway, then deceleration
    public static double EaseInOutQuart (double t, double b, double c, double d)
    {
        if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
        return -c/2 * ((t-=2)*t*t*t - 2) + b;
    }


    ///////////// QUINTIC EASING: t^5  ////////////////////

    // quintic easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in value, d: duration
    // t and d can be frames or seconds/milliseconds
    public static double EaseInQuint (double t, double b, double c, double d)
    {
        return c*(t/=d)*t*t*t*t + b;
    }

    // quintic easing out - decelerating to zero velocity
    public static double EaseOutQuint (double t, double b, double c, double d)
    {
        return c*((t=t/d-1)*t*t*t*t + 1) + b;
    }

    // quintic easing in/out - acceleration until halfway, then deceleration
    public static double EaseInOutQuint (double t, double b, double c, double d)
    {
        if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
        return c/2*((t-=2)*t*t*t*t + 2) + b;
    }


    ///////////// SINUSOIDAL EASING: sin(t) ///////////////

    // sinusoidal easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in position, d: duration
    public static double EaseInSine (double t, double b, double c, double d)
    {
        return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
    }

    // sinusoidal easing out - decelerating to zero velocity
    public static double EaseOutSine (double t, double b, double c, double d)
    {
        return c * Math.sin(t/d * (Math.PI/2)) + b;
    }

    // sinusoidal easing in/out - accelerating until halfway, then decelerating
    public static double EaseInOutSine (double t, double b, double c, double d)
    {
        return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
    }


    ///////////// EXPONENTIAL EASING: 2^t /////////////////

    // exponential easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in position, d: duration
    public static double EaseInExpo (double t, double b, double c, double d)
    {
        return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
    }

    // exponential easing out - decelerating to zero velocity
    public static double EaseOutExpo (double t, double b, double c, double d)
    {
        return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
    }

    // exponential easing in/out - accelerating until halfway, then decelerating
    public static double EaseInOutExpo (double t, double b, double c, double d)
    {
        if (t==0) return b;
        if (t==d) return b+c;
        if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
        return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
    }

    /////////// CIRCULAR EASING: sqrt(1-t^2) //////////////

    // circular easing in - accelerating from zero velocity
    // t: current time, b: beginning value, c: change in position, d: duration
    public static double EaseInCirc (double t, double b, double c, double d)
    {
        return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
    }

    // circular easing out - decelerating to zero velocity
    public static double EaseOutCirc (double t, double b, double c, double d)
    {
        return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
    }

    // circular easing in/out - acceleration until halfway, then deceleration
    public static double EaseInOutCirc (double t, double b, double c, double d)
    {
        if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
        return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
    }


    /////////// ELASTIC EASING: exponentially decaying sine wave  //////////////

    // t: current time, b: beginning value, c: change in value, d: duration, a: amplitude (optional), p: period (optional)
    // t and d can be in frames or seconds/milliseconds

    public static double EaseInElastic (double t, double b, double c, double d, double a, double p)
    {
        double s;
        if (t==0) return b;
        if ((t/=d)==1) return b+c;
        if (p == 0) p=d*0.3;
        if (a < Math.abs(c))
        {
            a=c;
            s=p/4;
        }
        else
        {
            s = p/(2*Math.PI) * Math.asin (c/a);
        }
        return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
    }

    public static double EaseOutElastic (double t, double b, double c, double d, double a, double p)
    {
        double s;
        if (t==0) return b;  if ((t/=d)==1) return b+c;
        if (p==0) p=d*.3;
        if (a < Math.abs(c)) { a=c; s=p/4; }
        else s = p/(2*Math.PI) * Math.asin (c/a);
        return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
    }

    public static double EaseInOutElastic (double t, double b, double c, double d, double a, double p)
    {
        double s;
        if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (p==0) p=d*(.3*1.5);
        if (a < Math.abs(c)) { a=c; s=p/4; }
        else s = p/(2*Math.PI) * Math.asin (c/a);
        if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
        return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
   }


    /////////// BACK EASING: overshooting cubic easing: (s+1)*t^3 - s*t^2  //////////////

    // back easing in - backtracking slightly, then reversing direction and moving to target
    // t: current time, b: beginning value, c: change in value, d: duration, s: overshoot amount (optional)
    // t and d can be in frames or seconds/milliseconds
    // s controls the amount of overshoot: higher s means greater overshoot
    // s has a default value of 1.70158, which produces an overshoot of 10 percent
    // s==0 produces cubic easing with no overshoot
    public static double EaseInBack (double t, double b, double c, double d, double s)
    {
        return c*(t/=d)*t*((s+1)*t - s) + b;
    }
   
    // This is an overload of EaseInBack so the user may have "s" filled with the default value:
    // (s = 1.70158)
    public static double EaseInBack (double t, double b, double c, double d)
    {
        return EaseInBack(t, b, c, d, 1.70158);
    }

    // back easing out - moving towards target, overshooting it slightly, then reversing and coming back to target
    public static double EaseOutBack (double t, double b, double c, double d, double s)
    {
        return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    }
   
    // This is an overload of EaseOutBack so the user may have "s" filled with the default value:
    // (s = 1.70158)
    public static double EaseOutBack (double t, double b, double c, double d)
    {
        return EaseOutBack(t, b, c, d, 1.70158);
    }

    // back easing in/out - backtracking slightly, then reversing direction and moving to target,
    // then overshooting target, reversing, and finally coming back to target
    public static double EaseInOutBack (double t, double b, double c, double d, double s)
    {
        if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
        return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
    }
   
    // This is an overload of EaseInOutBack so the user may have "s" filled with the default value:
    // (s = 1.70158)
    public static double EaseInOutBack (double t, double b, double c, double d)
    {
        return EaseInOutBack(t, b, c, d, 1.70158);
    }


    /////////// BOUNCE EASING: exponentially decaying parabolic bounce  //////////////

    // bounce easing in
    // t: current time, b: beginning value, c: change in position, d: duration
    public static double EaseInBounce (double t, double b, double c, double d)
    {
        return c - EaseOutBounce (d-t, 0, c, d) + b;
    }

    // bounce easing out
    public static double EaseOutBounce (double t, double b, double c, double d)
    {
        if ((t/=d) < (1/2.75)) return c*(7.5625*t*t) + b;
        else if (t < (2/2.75)) return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
        else if (t < (2.5/2.75)) return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
        else return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
    }

    // bounce easing in/out
    public static double EaseInOutBounce (double t, double b, double c, double d)
    {
        if (t < d/2) return EaseInBounce (t*2, 0, c, d) * .5 + b;
        return EaseOutBounce (t*2-d, 0, c, d) * .5 + c*.5 + b;
    }
}
