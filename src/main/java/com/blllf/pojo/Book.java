package com.blllf.pojo;

public class Book {

    private Integer id;
    private String name;
    private String isbn;
    private String press;
    private String author;
    private Integer pagination; //图书页数
    private Double price;
    private String uploadTime; //图书上架时间
    private String status;
    private String borrower;
    private String borrowTime;
    private String returnTime;


    public Book() {
    }

    public Book(Integer id, String name, String isbn, String press, String author, Integer pagination, Double price, String uploadTime, String status, String borrower, String borrowTime, String returnTime) {
        this.id = id;
        this.name = name;
        this.isbn = isbn;
        this.press = press;
        this.author = author;
        this.pagination = pagination;
        this.price = price;
        this.uploadTime = uploadTime;
        this.status = status;
        this.borrower = borrower;
        this.borrowTime = borrowTime;
        this.returnTime = returnTime;
    }

    /**
     * 获取
     * @return id
     */
    public Integer getId() {
        return id;
    }

    /**
     * 设置
     * @param id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * 获取
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * 设置
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * 获取
     * @return isbn
     */
    public String getIsbn() {
        return isbn;
    }

    /**
     * 设置
     * @param isbn
     */
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    /**
     * 获取
     * @return press
     */
    public String getPress() {
        return press;
    }

    /**
     * 设置
     * @param press
     */
    public void setPress(String press) {
        this.press = press;
    }

    /**
     * 获取
     * @return author
     */
    public String getAuthor() {
        return author;
    }

    /**
     * 设置
     * @param author
     */
    public void setAuthor(String author) {
        this.author = author;
    }

    /**
     * 获取
     * @return pagination
     */
    public Integer getPagination() {
        return pagination;
    }

    /**
     * 设置
     * @param pagination
     */
    public void setPagination(Integer pagination) {
        this.pagination = pagination;
    }

    /**
     * 获取
     * @return price
     */
    public Double getPrice() {
        return price;
    }

    /**
     * 设置
     * @param price
     */
    public void setPrice(Double price) {
        this.price = price;
    }

    /**
     * 获取
     * @return uploadTime
     */
    public String getUploadTime() {
        return uploadTime;
    }

    /**
     * 设置
     * @param uploadTime
     */
    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    /**
     * 获取
     * @return status
     */
    public String getStatus() {
        return status;
    }

    /**
     * 设置
     * @param status
     */
    public void setStatus(String status) {
        this.status = status;
    }

    /**
     * 获取
     * @return borrower
     */
    public String getBorrower() {
        return borrower;
    }

    /**
     * 设置
     * @param borrower
     */
    public void setBorrower(String borrower) {
        this.borrower = borrower;
    }

    /**
     * 获取
     * @return borrowTime
     */
    public String getBorrowTime() {
        return borrowTime;
    }

    /**
     * 设置
     * @param borrowTime
     */
    public void setBorrowTime(String borrowTime) {
        this.borrowTime = borrowTime;
    }

    /**
     * 获取
     * @return returnTime
     */
    public String getReturnTime() {
        return returnTime;
    }

    /**
     * 设置
     * @param returnTime
     */
    public void setReturnTime(String returnTime) {
        this.returnTime = returnTime;
    }

    public String toString() {
        return "Book{id = " + id + ", name = " + name + ", isbn = " + isbn + ", press = " + press + ", author = " + author + ", pagination = " + pagination + ", price = " + price + ", uploadTime = " + uploadTime + ", status = " + status + ", borrower = " + borrower + ", borrowTime = " + borrowTime + ", returnTime = " + returnTime + "}";
    }
}
