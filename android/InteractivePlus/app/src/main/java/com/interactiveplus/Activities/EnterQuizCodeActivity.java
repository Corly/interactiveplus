package com.interactiveplus.Activities;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.interactiveplus.Common.Constants;
import com.interactiveplus.R;

public class EnterQuizCodeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_enter_quiz_code);

        final EditText editTestQuizIdentifier = (EditText) findViewById(R.id.edit_text_quiz_identifier);
        final Button buttonStartQuiz = (Button) findViewById(R.id.button_start_quiz);
        final Context context = this;

        buttonStartQuiz.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String identifier = editTestQuizIdentifier.getText().toString();
                String url = Constants.GET_QUIZ_LINK + identifier + Constants.FORMAT_TYPE;

                RequestQueue queue = Volley.newRequestQueue(view.getContext());
                StringRequest stringRequest = new StringRequest(Request.Method.GET, url,
                        new Response.Listener<String>() {
                            @Override
                            public void onResponse(String response) {
                                // do stuff
                                Log.d("Debug", "A mers?");
                                Intent intent = new Intent(context, QuizActivity.class);
                                intent.putExtra("unparsedJson", response);
                                startActivity(intent);
                            }
                        },
                        new Response.ErrorListener() {
                            @Override
                            public void onErrorResponse(VolleyError error) {
                                // do other stuff
                                Log.d("Debug", "Nu a mers? " + error.toString());
                                Toast.makeText(EnterQuizCodeActivity.this, "Invalid identifier! Try again!", Toast.LENGTH_SHORT).show();
                            }
                        });

                queue.add(stringRequest);
            }
        });
    }


}
