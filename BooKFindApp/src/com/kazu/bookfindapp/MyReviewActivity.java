package com.kazu.bookfindapp;

import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ListView;
import android.widget.TextView;

import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;

public class MyReviewActivity extends Activity {

	BookAdapter adapter;
	Handler h = new Handler();

	// リストビューに表示する配列データ
	// String[]list = new String[]{
	// "username","bookTitle","bookReview"
	// };

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.myhistory);

		ParseQuery<ParseObject> query = ParseQuery.getQuery("Review");
		query.whereEqualTo("bookCompany", "テスト");

		Log.d("AllFind", "activity created.");

		query.findInBackground(new FindCallback<ParseObject>() {
			@Override
			public void done(List<ParseObject> objects, ParseException e) {
				Log.d("AllFind", "ParseQuery<ParseObject> done");
				if (objects != null) {
					for (int i = 0; i < objects.size(); i++) {
						ParseObject object = objects.get(i);
						Log.d("AllFind", object.getString("userName"));
						// Get list of players
						object.getString("userName");

						// BookをParseObject のリストに変換
						// => ParseObjectの情報をもとにBookを新しく作る
						final Book book = new Book(
								object.getString("userName"), object
										.getString("bookTitle"), object
										.getString("bookReview"));

						h.post(new Runnable() {
							@Override
							public void run() {
								// TODO Auto-generated method stub
								adapter.add(book);
								adapter.notifyDataSetChanged();
							}
						});
					}

				} else {
					// No players
				}
			}
		});

		ListView listView = (ListView) findViewById(R.id.listView);
		adapter = new BookAdapter();
		listView.setAdapter(adapter);

	}

	private class BookAdapter extends BaseAdapter {
		List<Book> books = new ArrayList<Book>();

		@Override
		public int getCount() {
			return books.size();
		}

		@Override
		public Object getItem(int position) {
			return books.get(position);
		}

		@Override
		public long getItemId(int position) {
			return position;
		}

		public void add(Book book) {
			books.add(book);
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			LayoutInflater inflater = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);

			convertView = inflater.inflate(R.layout.list, null);

			Book book = (Book) getItem(position);

			TextView nameText = (TextView) convertView
					.findViewById(R.id.userName);
			TextView titleText = (TextView) convertView
					.findViewById(R.id.bookTitle);
			TextView reviewText = (TextView) convertView
					.findViewById(R.id.bookReview);

			nameText.setText(book.userName);
			titleText.setText(book.bookTitle);
			reviewText.setText(book.bookReview);

			return convertView;
		}
	}
}

