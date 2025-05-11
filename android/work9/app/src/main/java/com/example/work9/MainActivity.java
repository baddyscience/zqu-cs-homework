package com.example.work9;

import android.content.Intent;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {
    private ListView listView;
    private Button btnParse;
    private int selectedPosition = -1;

    private static final String JSON_DATA = "["
            + "{\"sid\":1001,\"name\":\"张大山\",\"age\":21},"
            + "{\"sid\":1002,\"name\":\"李小丽\",\"age\":22},"
            + "{\"sid\":1003,\"name\":\"王强\",\"age\":23}"
            + "]";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        listView = findViewById(R.id.listView);
        btnParse = findViewById(R.id.btnParse);

        // 解析原始JSON数据
        List<Student> students = parseJsonData(JSON_DATA);

        // 设置列表适配器
        ArrayAdapter<Student> adapter = new ArrayAdapter<Student>(
                this,
                android.R.layout.simple_list_item_activated_1,
                students
        ) {
            @NonNull
            @Override
            public View getView(int position, View convertView, @NonNull ViewGroup parent) {
                TextView textView = (TextView) super.getView(position, convertView, parent);
                Student student = getItem(position);
                textView.setText(student.name + " - 学号：" + student.sid);
                return textView;
            }
        };

        listView.setAdapter(adapter);

        // 列表选择监听
        listView.setOnItemClickListener((parent, view, position, id) -> {
            selectedPosition = position;
            view.setSelected(true);
        });

        // 解析按钮点击事件
        btnParse.setOnClickListener(v -> {
            if (selectedPosition != -1) {
                Student selected = (Student) listView.getItemAtPosition(selectedPosition);
                Intent intent = new Intent(MainActivity.this, DetailActivity.class);
                intent.putExtra("student", selected);
                startActivity(intent);
                overridePendingTransition(R.drawable.slide_in_right, R.drawable.slide_out_left);
            } else {
                Toast.makeText(this, "请先选择要解析的数据", Toast.LENGTH_SHORT).show();
            }
        });
    }

    private List<Student> parseJsonData(String json) {
        List<Student> students = new ArrayList<>();
        try {
            JSONArray jsonArray = new JSONArray(json);
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject obj = jsonArray.getJSONObject(i);

                // 关键点：严格匹配字段名称
                Student student = new Student(
                        obj.getInt("sid"),       // 必须与JSON字段名一致
                        obj.getString("name"),   // 注意大小写
                        obj.getInt("age")        // 新增字段
                );

                // 调试日志
                Log.d("JSON_PARSE", "解析结果: " + student);
                students.add(student);
            }
        } catch (JSONException e) {
            Log.e("JSON_ERROR", "解析失败: " + e.getMessage());
        }
        return students;
    }

    // 实现Parcelable的数据类
    public static class Student implements Parcelable {
        public final int sid;
        public final String name;
        public final int age;

        protected Student(Parcel in) {
            sid = in.readInt();
            name = in.readString();
            age = in.readInt();
        }

        public static final Creator<Student> CREATOR = new Creator<Student>() {
            @Override
            public Student createFromParcel(Parcel in) {
                return new Student(in);
            }

            @Override
            public Student[] newArray(int size) {
                return new Student[size];
            }
        };

        public Student(int sid, String name, int age) {
            this.sid = sid;
            this.name = name;
            this.age = age;
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel dest, int flags) {
            dest.writeInt(sid);
            dest.writeString(name);
            dest.writeInt(age);
        }
    }
}

