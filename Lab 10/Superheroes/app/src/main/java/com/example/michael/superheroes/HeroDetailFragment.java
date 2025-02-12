package com.example.michael.superheroes;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.app.Fragment;
import android.util.Log;
import android.view.ContextMenu;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import java.util.ArrayList;

public class HeroDetailFragment extends Fragment implements View.OnClickListener{

    public HeroDetailFragment() {
    }

    private long universeId; //id of the universe chosen

    public void setUniverse(long id){
        this.universeId = id;
    }

    private ArrayAdapter<String> adapter;

    interface ButtonClickListener{
        void addheroclicked(View view);
    }

    private ButtonClickListener listener;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        if (savedInstanceState !=null){
            universeId = savedInstanceState.getLong("universeId");
        }
        if (Hero.heroes[0].getSuperheroes().size() == 0 ) {
            Hero.heroes[0].loadHeroes(getActivity(), 0);
        }
        if (Hero.heroes[1].getSuperheroes().size() == 0 ) {
            Hero.heroes[1].loadHeroes(getActivity(), 1);
        }
        return inflater.inflate(R.layout.fragment_hero_detail, container, false);
    }

    @Override public void onStart(){
        super.onStart();

        View view = getView();
        ListView listHeroes = (ListView)view.findViewById(R.id.herolistView);

        ArrayList<String> herolist = new ArrayList<String>();
        herolist = Hero.heroes[(int) universeId].getSuperheroes();

        adapter = new ArrayAdapter<String>(getActivity(), android.R.layout.simple_list_item_1, herolist);

        listHeroes.setAdapter(adapter);

        Button addButton = (Button)view.findViewById(R.id.addButton);
        addButton.setOnClickListener(this);

        registerForContextMenu(listHeroes);

    }

    @Override public void onSaveInstanceState(Bundle savedInstanceState){
        savedInstanceState.putLong("universeId", universeId);
    }

    @Override public void onAttach(Activity activity){
        Log.i("Attached", "Called onAttach");
        super.onAttach(activity);
        listener = (ButtonClickListener)activity;
    }

    @Override public void onAttach(Context context) {
        super.onAttach(context);
        listener = (ButtonClickListener)context;
    }

    @Override public void onClick(View view){
        Log.i("CLICKED", "BUTTON CLICKED");
        if (listener !=null){
            listener.addheroclicked(view);
        } else {
            Log.i("LISTENER", "Listener = NULL");
        }
    }

    public void addhero(){
        Log.d("CLICK", "onClick: Button Clicked");
        final Dialog dialog = new Dialog(getActivity());
        dialog.setContentView(R.layout.dialog);
        dialog.setTitle("Add Hero");
        dialog.setCancelable(true);
        final EditText editText = (EditText) dialog.findViewById(R.id.editTextHero);
        Button button = (Button) dialog.findViewById(R.id.addButton);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                String heroName = editText.getText().toString();
                Hero.heroes[(int) universeId].getSuperheroes().add(heroName);
                HeroDetailFragment.this.adapter.notifyDataSetChanged();
                Hero.heroes[(int) universeId].storeHeroes(getActivity(), universeId);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    //create a context menu on long press
    @Override public void onCreateContextMenu(ContextMenu menu, View view, ContextMenu.ContextMenuInfo menuInfo){
        super.onCreateContextMenu(menu, view, menuInfo);
        AdapterView.AdapterContextMenuInfo adapterContextMenuInfo = (AdapterView.AdapterContextMenuInfo) menuInfo;
        String heroname = adapter.getItem(adapterContextMenuInfo.position);
        Log.d("DELETE", "onCreateContextMenu: Deleted");
        menu.setHeaderTitle("Delete " + heroname);
        menu.add(1, 1, 1, "Yes");
        menu.add(2, 2, 2, "No");
    }

    //handle context menu item selection
    @Override public boolean onContextItemSelected(MenuItem item){
        int itemId = item.getItemId();
        if (itemId == 1) { //if yes menu item was pressed
            AdapterView.AdapterContextMenuInfo info = (AdapterView.AdapterContextMenuInfo) item.getMenuInfo();
            Hero.heroes[(int) universeId].getSuperheroes().remove(info.position);
            HeroDetailFragment.this.adapter.notifyDataSetChanged();
            Hero.heroes[(int) universeId].storeHeroes(getActivity(), universeId);
        }
        return true;
    }

    //reference: http://www.survivingwithandroid.com/2012/10/android-listviewarrayadapter-and.html

}
