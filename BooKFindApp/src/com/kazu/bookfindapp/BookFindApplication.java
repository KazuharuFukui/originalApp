package com.kazu.bookfindapp;

import com.parse.Parse;
import com.parse.ParseACL;
import com.parse.ParseUser;

import android.app.Application;

public class BookFindApplication extends Application{
	@Override
	public void onCreate(){
		super.onCreate();
		
		Parse.initialize(this, "Q4PzGhE5c9Ms53u9eVp9jxbujShNNPLqrXYYeUwV",
				"xXxzn0yYILvvmrIAegGGkMbELSeRKgcJWSesqUfR");
		ParseUser.enableAutomaticUser();
		ParseACL defaultACL = new ParseACL();
		ParseACL.setDefaultACL(defaultACL, true);
		
	}
	
}
