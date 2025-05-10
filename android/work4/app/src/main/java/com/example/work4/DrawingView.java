package com.example.work4;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;

import java.util.ArrayList;
import java.util.List;

public class DrawingView extends View {
    private static final int DEFAULT_COLOR = Color.RED;
    private static final float STROKE_WIDTH = 8f;

    private Paint paint;
    private Path currentPath;
    private List<DrawingPath> paths = new ArrayList<>();
    private int currentColor = DEFAULT_COLOR;

    public DrawingView(Context context) {
        super(context);
        init();
    }

    public DrawingView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public DrawingView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init() {
        paint = new Paint();
        paint.setAntiAlias(true);
        paint.setDither(true);
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeJoin(Paint.Join.ROUND);
        paint.setStrokeCap(Paint.Cap.ROUND);
        paint.setStrokeWidth(STROKE_WIDTH);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        // 绘制所有历史路径
        for (DrawingPath dp : paths) {
            paint.setColor(dp.color);
            canvas.drawPath(dp.path, paint);
        }
        // 绘制当前路径
        if (currentPath != null) {
            paint.setColor(currentColor);
            canvas.drawPath(currentPath, paint);
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        float x = event.getX();
        float y = event.getY();

        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                currentPath = new Path();
                currentPath.moveTo(x, y);
                invalidate();
                return true;

            case MotionEvent.ACTION_MOVE:
                currentPath.lineTo(x, y);
                invalidate();
                return true;

            case MotionEvent.ACTION_UP:
                paths.add(new DrawingPath(currentPath, currentColor));
                currentPath = null;
                invalidate();
                return true;
        }
        return false;
    }

    public void setColor(int color) {
        currentColor = color;
    }

    public void clear() {
        paths.clear();
        invalidate();
    }

    // 路径数据封装类
    private static class DrawingPath {
        Path path;
        int color;

        DrawingPath(Path path, int color) {
            this.path = path;
            this.color = color;
        }
    }
}
