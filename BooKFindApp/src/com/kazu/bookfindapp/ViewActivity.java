package com.kazu.bookfindapp;

import java.util.List;

import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

import android.app.Activity;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.view.View;

public class ViewActivity extends Activity {

	/** Called when the activity is first created. */
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.view);
        
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Review");
		query.findInBackground(new FindCallback<ParseObject>() {

			@Override
			public void done(List<ParseObject> objects, ParseException e) {
				// TODO 全部のオブジェクトのリスト(objects)に対してなにかする
				for (int i = 0; i < objects.size(); i++) {
					ParseObject obj = objects.get(i);
					// このオブジェクトに対してなにかする？
					// たとえば、listViewに追加するとか？
					
				}
			}
		});
        
        }
}
