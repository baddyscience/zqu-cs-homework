package com.example.work3;

import android.app.Activity;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;

public class DraggableBallView extends View {
    private static final int BALL_RADIUS = 50;
    private static final int SQUARE_SIZE = 20;
    private float ballX = 300, ballY = 300;
    private boolean isDragging = false;
    private Rect targetRect;

    public DraggableBallView(Context context) {
        super(context);
        init();
    }

    public DraggableBallView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public DraggableBallView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    // 初始化目标矩形坐标（需在布局完成后获取）
    private void init() {
        post(() -> {
            View target = ((Activity)getContext()).findViewById(R.id.target_rect);
            if (target != null) { // 空值检查
                int[] loc = new int[2];
                target.getLocationOnScreen(loc);
                targetRect = new Rect(
                        loc[0], loc[1],
                        loc[0] + target.getWidth(),
                        loc[1] + target.getHeight()
                );
            }
        });
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        // 绘制蓝色小球
        Paint ballPaint = new Paint();
        ballPaint.setColor(Color.BLUE);
        canvas.drawCircle(ballX, ballY, BALL_RADIUS, ballPaint);

        // 绘制白色中心方块
        Paint squarePaint = new Paint();
        squarePaint.setColor(Color.WHITE);
        canvas.drawRect(
                ballX - SQUARE_SIZE/2f,
                ballY - SQUARE_SIZE/2f,
                ballX + SQUARE_SIZE/2f,
                ballY + SQUARE_SIZE/2f,
                squarePaint
        );
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getAction()) {
            case MotionEvent.ACTION_DOWN:
                // 检测触摸点是否在小球范围内
                if (isInBall(event.getX(), event.getY())) {
                    isDragging = true;
                }
                return true;

            case MotionEvent.ACTION_MOVE:
                if (isDragging) {
                    // 更新小球位置
                    ballX = event.getX();
                    ballY = event.getY();
                    checkCollision();
                    invalidate();
                }
                return true;

            case MotionEvent.ACTION_UP:
                isDragging = false;
                return true;
        }
        return super.onTouchEvent(event);
    }

    // 碰撞检测
    private void checkCollision() {
        if (targetRect == null) return;

        Rect ballArea = new Rect(
                (int)(ballX - BALL_RADIUS),
                (int)(ballY - BALL_RADIUS),
                (int)(ballX + BALL_RADIUS),
                (int)(ballY + BALL_RADIUS)
        );

        if (Rect.intersects(ballArea, targetRect)) {
            ((Activity)getContext()).finish();
        }
    }

    // 判断触摸点是否在球内
    private boolean isInBall(float x, float y) {
        return Math.sqrt(Math.pow(x - ballX, 2) + Math.pow(y - ballY, 2)) <= BALL_RADIUS;
    }
}
