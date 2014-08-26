package com.kazu.bookfindapp;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;

import com.parse.ParseObject;

public class RecordActivity extends Activity {

	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.record);

		Button saveButton = (Button) findViewById(R.id.savebt);
		saveButton.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View arg0) {
				saveButtonClick();
			}
		});

		

	}

	private void saveButtonClick() {	
		EditText editUserName = (EditText) findViewById(R.id.editUserName);
		EditText editBookTitle = (EditText) findViewById(R.id.editBookTitle);
		EditText editBookAutor = (EditText) findViewById(R.id.editBookAutor);
		EditText editBookCompany = (EditText) findViewById(R.id.editBookCompany);
	    EditText editBookReview = (EditText) findViewById(R.id.editBookReview);
		
		
		ParseObject review = new ParseObject("Review");
		review.put("userName", editUserName.getText().toString());
		review.put("bookTitle", editBookTitle.getText().toString());
		review.put("bookAuthor", editBookAutor.getText().toString());
		review.put("bookCompany", editBookCompany.getText().toString());
		review.put("bookReview", editBookReview.getText().toString());
		//review.put("reviewOpen", checkReviewOpen.isChecked());
		review.saveInBackground();
		
		// ï€ë∂
//		EditText editText = (EditText) findViewById(R.id.editTextname);
//		SharedPreferences sp = PreferenceManager
//				.getDefaultSharedPreferences(this);
//		sp.edit().putString("SaveString", editText.getText().toString())
//				.commit();
		
	}

//	private void loadButtonClick() {
//		// ì«Ç›çûÇ›
//		EditText editText = (EditText) findViewById(R.id.editTextname);
//		SharedPreferences sp = PreferenceManager
//				.getDefaultSharedPreferences(this);
//		editText.setText(sp.getString("SaveString", null), BufferType.NORMAL);
//	}
	
}
