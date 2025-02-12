package com.example.michael.superheroes;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

public class DetailActivity extends AppCompatActivity implements HeroDetailFragment.ButtonClickListener {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_detail);

        HeroDetailFragment heroDetailFragment = (HeroDetailFragment) getFragmentManager().findFragmentById(R.id.fragment_container);
        int universeId = (int) getIntent().getExtras().get("id");
        heroDetailFragment.setUniverse(universeId);
    }

    @Override public void addheroclicked(View view){
        Log.i("ADDHEROCLICKED", "Button was clicked");
        HeroDetailFragment fragment = (HeroDetailFragment)getFragmentManager().findFragmentById(R.id.fragment_container);
        fragment.addhero();
    }
}
