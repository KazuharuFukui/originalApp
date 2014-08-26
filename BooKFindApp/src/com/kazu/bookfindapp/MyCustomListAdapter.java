package com.kazu.bookfindapp;

import java.util.List;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

public class MyCustomListAdapter extends ArrayAdapter<MyCustomListData > {
    private LayoutInflater layoutInflater;
    //- �w�i�F�ύX���f�p�t���O
    private int loopCount = 1;

    private Context myContext;

    public MyCustomListAdapter (Context context, int viewResourceId, List<MyCustomListData> objects) {
        super(context, viewResourceId, objects);
        myContext = context;
        layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        //- ����̍s(position)�̃f�[�^�𓾂�
        MyCustomListData item = (MyCustomListData)getItem(position);

        //- ���X�g�p�̃��C�A�E�g������̂ݍ쐬
        if( convertView == null ) {
             convertView = layoutInflater.inflate(R.layout.list, null);
        }

        LinearLayout linearLayout = (LinearLayout) convertView.findViewById(R.id.listContainer);
        
        //- �w�i�F�����݂ɓ��ւ���
        if( loopCount%2 == 0 ) {
             linearLayout.setBackgroundColor(myContext.getResources().getColor(R.color.listFirst));
        } else {
             linearLayout.setBackgroundColor(myContext.getResources().getColor(R.color.listSecond));
        }
        loopCount++; 

        //- �C���[�W�摜�̃Z�b�g
        //ImageView imageView = (ImageView) convertView.findViewById(R.id.listImg);
        //imageView.setImageBitmap(item.getBitmap());
        
        //- ���b�Z�[�W�̃Z�b�g
        TextView userNameTextView = (TextView) convertView.findViewById(R.id.userName);
        userNameTextView .setText(item.getName());
        
      //- ���b�Z�[�W�̃Z�b�g
        TextView bookReviewTextView = (TextView) convertView.findViewById(R.id.bookReview);
        bookReviewTextView .setText(item.getReview());
        
        return convertView;
    }
}