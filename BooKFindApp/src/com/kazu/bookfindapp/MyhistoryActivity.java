/**myhistory.xmlの最初の案*/
package com.kazu.bookfindapp;

import java.util.ArrayList;
import java.util.List;

import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.Parse;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseQueryAdapter;

import android.app.Activity;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.View;
import android.widget.Adapter;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;

public class MyhistoryActivity extends Activity {

	private ListView listView;
	private EditText editText;
	private Button button;

	private ArrayAdapter<String> adapter;

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		//setContentView(R.layout.myhistory);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("Review");
		// query.whereEqualTo("userName", "いちげん");
		query.findInBackground(new FindCallback<ParseObject>() {
			public void done(List<ParseObject> reviewList, ParseException e) {
				ParseObject review = new ParseObject("Review");
				if (e == null) {
					review.put("bookReview", "Retrieved " + reviewList.size()
							+ " review");
				} else {
					review.put("bookReview", "Error: " + e.getMessage());
				}

			}
		});
		// ListView第６回教科書
		ParseQueryAdapter<ParseObject> adapter = new ParseQueryAdapter<ParseObject>(
				this, "Review");
		adapter.setTextKey("bookReview");
		adapter.setTextKey("userName");
		listView = (ListView) findViewById(R.id.listView);
		listView.setAdapter(adapter);
		// テスト用
		/*
		 * ArrayList<ParseObject> reviews = new ArrayList<ParseObject>(); Review
		 * review1 = ParseObject.create(Review.class); review1.bookTitle =
		 * "あああ"; Review review2 = ParseObject.create(Review.class);
		 * review2.bookTitle = "いいい"; reviews.add(review1);
		 * reviews.add(review2);
		 */
		// for (ParseObject bookReview: reviews) {
		// System.out.println(bookReview); }
/**
		Integer[] imgList = { R.drawable.a, R.drawable.b, R.drawable.c };
		String[] msgList = { "a画像だよ", "b画像だよ", "c画像だよ" };
		List<MyCustomListData> objects = new ArrayList<MyCustomListData>();

		for (int i = 0; i < imgList.length; i++) {
			MyCustomListData tmpItem = new MyCustomListData();
			tmpItem.setBitmap(BitmapFactory.decodeResource(getResources(),
					imgList[i]));
			tmpItem.setName(msgList[i]);
			objects.add(tmpItem);
		}
		MyCustomListAdapter myCustomListAdapter = new MyCustomListAdapter(this,
				0, objects);
		ListView listView = (ListView) findViewById(R.id.listView);
		listView.setAdapter(myCustomListAdapter);*/
	}

}