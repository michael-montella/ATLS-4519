package com.example.michael.spring;

/**
 * Created by Michael Montella on 4/2/16.
 */
public class Bulb {
    private String name;
    private int imageResourceID;
    private String price;

    //constructor
    private Bulb(String newname, int newID, String newPrice){
        this.name = newname;
        this.imageResourceID = newID;
        this.price = newPrice;
    }

    public static final Bulb[] tulips = {
            new Bulb("Daydream", R.drawable.daydream, "3"),
            new Bulb("Apeldoorn Elite", R.drawable.apeldoorn , "3"),
            new Bulb("Banja Luka", R.drawable.banjaluka, "3"),
            new Bulb("Burning Heart", R.drawable.burningheart, "3"),
            new Bulb("Cape Cod", R.drawable.capecod, "3")
    };

    public static final Bulb[] daffodils = {
            new Bulb("Bella Vista", R.drawable.bellavista, "3"),
            new Bulb("Big Gun", R.drawable.biggun, "3"),
            new Bulb("Full House", R.drawable.fullhouse, "3"),
            new Bulb("Ice Follies", R.drawable.icefollies, "3"),
            new Bulb("Yellow Hoop", R.drawable.yellowhoop, "3")
    };

    public static final Bulb[] iris = {
            new Bulb("Blazing Sunrise", R.drawable.blazingsunrise, "3"),
            new Bulb("October Sun", R.drawable.octobersun, "3"),
            new Bulb("Purple Night Sky", R.drawable.purplenightsky, "3"),
            new Bulb("Temper Tantrum", R.drawable.tempertantrum, "3"),
            new Bulb("Victoria Falls", R.drawable.victoriafalls, "3")
    };

    public String getName(){
        return name;
    }

    public int getImageResourceID(){
        return imageResourceID;
    }

    //the string representation of a tulip is its name
    public String toString(){
        return this.name;
    }

}
