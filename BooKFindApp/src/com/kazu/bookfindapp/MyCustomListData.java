package com.kazu.bookfindapp;

import java.util.List;

public class MyCustomListData {
      private String userName;
      private String bookTitle;
      private String bookReview;

      public void setName(String msg) {
          userName = msg;
      }
      public String getName() {
        return userName;
      }
      
      public void setTitle(String msg) {
          bookTitle = msg;
      }
      public String getTitle() {
        return bookTitle;
      }
      
      public void setReview(String msg) {
          bookReview = msg;
      }
      public String getReview() {
        return bookReview;
      }

      
  }