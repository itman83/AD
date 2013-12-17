/*
package com.cnfa.db;

import android.content.Context;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DBManager {
    public static final String DATABASE_NAME = "user.sqlite";

    public static final int DATABASE_VERSION = 1;

    public static final String TABLE_AMITY_MARKETING = "amity_marketing";

    public static final String DB_CREATE = "create table ";

    public static final String COLUMN_ID = "id";

    public static final String COLUMN_XML_DATA = "xml_data";

    public static final String COLUMN_DATE_TIME = "date_time";

    static final String CREATE_TABLE_AMITY_MARKETING = DB_CREATE + TABLE_AMITY_MARKETING + "("
            + COLUMN_ID + " text primary key not null," + COLUMN_XML_DATA + " text, "
            + COLUMN_DATE_TIME + " text);";

    private SQLiteDatabase sqlDB;

    private DBAdapter dbHelper;

    *//**
     * Constructor for accessing the DB
     * 
     * @param context
     *//*

    public void setSqlDB(SQLiteDatabase sqlDB) {
        this.sqlDB = sqlDB;
    }

    public SQLiteDatabase getSqlDB() {
        return sqlDB;
    }

    public DBManager(Context context) {
        this.dbHelper = new DBAdapter(context);
    }

    // Opens the database
    public DBManager open() throws SQLException {
        this.sqlDB = dbHelper.getWritableDatabase();
        return this;
    }

    // Closes the database
    public void close() {
        dbHelper.close();
    }

    *//**
     * Database helper class
     * 
     * @author kumar
     *//*
    private static class DatabaseHelper extends SQLiteOpenHelper {
        public DatabaseHelper(Context context) {
            super(context, DATABASE_NAME, null, DATABASE_VERSION);
        }

        @Override
        public void onCreate(SQLiteDatabase db) {
            db.execSQL(CREATE_TABLE_AMITY_MARKETING);

        }

        @Override
        public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        }
    }

    public AmityMarketingTable getAmityMarketingTable() {
        return AmityMarketingTable.getInstance(sqlDB);
    }

}
*/