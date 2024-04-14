package com.blllf.pojo;

public class Record {
    private Integer id;
    private String bookname;
    private String bookisbn;
    private String borrower;
    private String borrowtime;
    private String remandtime;

    public Record() {
    }

    public Record(Integer id, String bookname, String bookisbn, String borrower, String borrowtime, String remandtime) {
        this.id = id;
        this.bookname = bookname;
        this.bookisbn = bookisbn;
        this.borrower = borrower;
        this.borrowtime = borrowtime;
        this.remandtime = remandtime;
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
     * @return bookname
     */
    public String getBookname() {
        return bookname;
    }

    /**
     * 设置
     * @param bookname
     */
    public void setBookname(String bookname) {
        this.bookname = bookname;
    }

    /**
     * 获取
     * @return bookisbn
     */
    public String getBookisbn() {
        return bookisbn;
    }

    /**
     * 设置
     * @param bookisbn
     */
    public void setBookisbn(String bookisbn) {
        this.bookisbn = bookisbn;
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
     * @return borrowtime
     */
    public String getBorrowtime() {
        return borrowtime;
    }

    /**
     * 设置
     * @param borrowtime
     */
    public void setBorrowtime(String borrowtime) {
        this.borrowtime = borrowtime;
    }

    /**
     * 获取
     * @return remandtime
     */
    public String getRemandtime() {
        return remandtime;
    }

    /**
     * 设置
     * @param remandtime
     */
    public void setRemandtime(String remandtime) {
        this.remandtime = remandtime;
    }

    public String toString() {
        return "Record{id = " + id + ", bookname = " + bookname + ", bookisbn = " + bookisbn + ", borrower = " + borrower + ", borrowtime = " + borrowtime + ", remandtime = " + remandtime + "}";
    }
}
