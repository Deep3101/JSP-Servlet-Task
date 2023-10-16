package com.webapp.model;

public class Address {
    private int userId;
    private String address1;
    private String apartment1;
    private String zipcode1;
    private String selectCity;
    private String selectState;
    private int addressId;

    public Address() {

    }
    // Constructors

    public Address(String address1, String apartment1, String zipcode1, String selectCity, String selectState, int addressId) {
        this.address1 = address1;
        this.apartment1 = apartment1;
        this.zipcode1 = zipcode1;
        this.selectCity = selectCity;
        this.selectState = selectState;
        this.addressId = addressId;
    }


    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public void setApartment1(String apartment1) {
        this.apartment1 = apartment1;
    }

    public void setZipcode1(String zipcode1) {
        this.zipcode1 = zipcode1;
    }

    public void setSelectCity(String selectCity) {
        this.selectCity = selectCity;
    }

    public void setSelectState(String selectState) {
        this.selectState = selectState;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getAddressId() {
        return addressId;
    }


    // Getters for properties
    public String getAddress1() {
        return address1;
    }

    public String getApartment1() {
        return apartment1;
    }

    public String getZipcode1() {
        return zipcode1;
    }

    public String getSelectCity() {
        return selectCity;
    }

    public String getSelectState() {
        return selectState;
    }

}
