namespace my.bookshop;

entity Books {
    key ID : Integer;
    title  : String(100);
    descr  : String(255);
    author : String(100);
}
