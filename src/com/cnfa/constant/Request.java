package com.cnfa.constant;

import java.util.Hashtable;

import org.xml.sax.ContentHandler;

public class Request {
	public static final int TYPE_GET = 0;  //For Get Request 
	public static final int TYPE_POST = 1; //For Post Request
	public static final int TYPE_MULTI_PART = 2; //For Post Request
	public static final int TYPE_LOG = 3;
	
	private String uri;
	private int requestId;
	private int requestType;
	private int timeoutSeconds;
	private Hashtable properties;
	private int priority;
	private ContentHandler parserHandler;
	private String payload;
	
	public Request(){
	}
	
	public String getUri() {
		return uri;
	}
	public void setUri(String uri) {
		this.uri = uri;
	}
	public int getRequestType() {
		return requestType;
	}
	public void setRequestType(int requestType) {
		this.requestType = requestType;
	}
	public int getTimeoutSeconds() {
		return timeoutSeconds;
	}
	public void setTimeoutSeconds(int timeoutSeconds) {
		this.timeoutSeconds = timeoutSeconds;
	}
	public Hashtable getProperties() {
		return properties;
	}
	public void setProperties(Hashtable properties) {
		this.properties = properties;
	}
	public int getPriority() {
		return priority;
	}
	public void setPriority(int priority) {
		this.priority = priority;
	}
	public ContentHandler getParser() {
		return parserHandler;
	}
	public void setParser(ContentHandler parser) {
		this.parserHandler = parser;
	}
	public String getPayload() {
		return payload;
	}
	public void setPayload(String payload) {
		this.payload = payload;
	}
	public int getRequestId() {
		return requestId;
	}
	public void setRequestId(int requestId) {
		this.requestId = requestId;
	}
}
