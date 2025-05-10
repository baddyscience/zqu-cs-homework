package com.example.work4;

import android.graphics.Color;
import android.os.Bundle;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {
    private DrawingView drawingView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        drawingView = findViewById(R.id.drawing_view);

        // 红色按钮
        findViewById(R.id.btn_red).setOnClickListener(v ->
                drawingView.setColor(Color.RED));

        // 蓝色按钮
        findViewById(R.id.btn_blue).setOnClickListener(v ->
                drawingView.setColor(Color.BLUE));

        // 绿色按钮
        findViewById(R.id.btn_green).setOnClickListener(v ->
                drawingView.setColor(Color.GREEN));

        // 清除按钮
        findViewById(R.id.btn_clear).setOnClickListener(v ->
                drawingView.clear());
    }
}