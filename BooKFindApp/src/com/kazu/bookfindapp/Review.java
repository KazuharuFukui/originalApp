package com.kazu.bookfindapp;

import com.parse.ParseClassName;
import com.parse.ParseObject;

@ParseClassName("Review")
public class Review extends ParseObject {
	String userName;
	String bookTitle;
	String bookAuthor;
	String bookCompany;
	String bookReview;
	boolean reviewOpen;
	
	
	
}
