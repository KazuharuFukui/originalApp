package com.kazu.bookfindapp;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;

import com.parse.Parse;
import com.parse.ParseInstallation;
import com.parse.ParseObject;
import com.parse.PushService;

public class MainActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		Parse.initialize(this, "Q4PzGhE5c9Ms53u9eVp9jxbujShNNPLqrXYYeUwV",
				"xXxzn0yYILvvmrIAegGGkMbELSeRKgcJWSesqUfR");

		PushService.setDefaultPushCallback(this, MainActivity.class);
		ParseInstallation.getCurrentInstallation().saveInBackground();

		Button findbt = (Button) findViewById(R.id.findbt);
		findbt.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				// Find画面を起動
				Intent intent = new Intent(getApplicationContext(),
						FindActivity.class);
				startActivity(intent);
			}
		});
		ImageButton findbt2 = (ImageButton) findViewById(R.id.findbt2);
		findbt2.setImageResource(R.drawable.findon);
		findbt2.setOnClickListener(new OnClickListener() {

			public void onClick(View v) {
				// Find画面を起動
				Intent intent = new Intent(getApplicationContext(),
						FindActivity.class);
				startActivity(intent);
			}
		});

		Button myhistorybt = (Button) findViewById(R.id.myhistorybt);
		myhistorybt.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				// マイレビュー画面を起動
				Intent intent = new Intent(getApplicationContext(),
						MyReviewActivity.class);
				startActivity(intent);
			}
		});
		ImageButton myhistorybt2 = (ImageButton) findViewById(R.id.myhistorybt2);
		myhistorybt2.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				// マイレビュー画面を起動
				Intent intent = new Intent(getApplicationContext(),
						MyReviewActivity.class);
				startActivity(intent);
			}
		});

		Button recordbt = (Button) findViewById(R.id.recordbt);
		recordbt.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				// 投稿画面を起動
				Intent intent = new Intent(getApplicationContext(),
						RecordActivity.class);
				startActivity(intent);
			}
		});
		ImageButton recordbt2 = (ImageButton) findViewById(R.id.recordbt2);
		recordbt2.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				// 投稿画面を起動
				Intent intent = new Intent(getApplicationContext(),
						RecordActivity.class);
				startActivity(intent);
			}
		});
		
		ImageButton allbt = (ImageButton) findViewById(R.id.allbt);
		allbt.setOnClickListener(new OnClickListener() {
			public void onClick(View v) {
				// すべて画面を起動
				Intent intent = new Intent(getApplicationContext(),
						AllFindActivity.class);
				startActivity(intent);
			}
		});
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

}
