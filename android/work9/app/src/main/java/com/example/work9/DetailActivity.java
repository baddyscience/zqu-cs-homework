package com.example.work9;

import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import androidx.appcompat.app.AppCompatActivity;

public class DetailActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        MainActivity.Student student = getIntent().getParcelableExtra("student");

        ListView resultList = findViewById(R.id.resultList);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(
                this,
                android.R.layout.simple_list_item_1,
                new String[]{
                        "姓名：" + student.name,
                        "学号：" + student.sid,
                        "年龄：" + student.age
                }
        );

        resultList.setAdapter(adapter);
    }
}