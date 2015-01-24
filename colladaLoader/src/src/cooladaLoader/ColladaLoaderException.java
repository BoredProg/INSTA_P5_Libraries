package cooladaLoader;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 *
 * <p>This Custom Exception is used to debug any problems in a convenient
 * way</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.1
 */
public class ColladaLoaderException extends RuntimeException{
	
	//let that private
	private ColladaLoaderException(){}
	
	/**
	 * Use this constructor outside catch-blockes
	 * @param special info to debug any problems
	 */
	public ColladaLoaderException(String s)
	{
		this(s, new ColladaLoaderException());
	}
	/**
	 * Use this constructor as facade
	 * @param msg additional messages
	 * @param ex throwed Exception inside a catch block
	 */
	public ColladaLoaderException(String msg, Throwable ex) {
		super(concatMsg(msg, ex));
        if (ex!=null) setStackTrace(ex.getStackTrace());
    }
	private static String concatMsg(String customMsg, Throwable cause)
	{
		String exClass = (cause==null)?"unknown Exception":cause.getClass().getSimpleName();
		String linePos = "unknown";
		String causeMsg = "no extended message";
    	if (cause != null)
    	{
    		StackTraceElement el = cause.getStackTrace()[0];
    		linePos = el.getLineNumber()+" on "+el.getClassName();
    		causeMsg = cause.getMessage();
    	}
    	
    	String internMessage = "\nA "+exClass+" is thrown: at Line "+linePos+
		"\nwith message: "+causeMsg+"\nColladaLoader says: "+customMsg;

    	return internMessage;

	}
  
}
