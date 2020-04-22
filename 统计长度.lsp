;【统计长度】

(defun c:tjcd(/  pt1 pt2 ss e  el n f2 attlist att_txt l_s l_t ecvla timenow)

   (vl-load-com)
   
   (setq pt1 (getpoint "请选择图形左上角:\n"))
   (setq pt2 (getcorner pt1 "请选择图形右下角:\n"))
   (PRINC "\n统计长度，反馈请联系:李劲松（18919611085） \n")(PRINC)
   
   (setq l_s 0 l_t 0)
   ;(setq ss (ssget "_W" pt1 pt2  '((0 . "insert" ))))
   (setq ss (ssget "_W" pt1 pt2  ))
   (if (/= ss nil) 
     (progn
       (setq n 0) ;序号的初值为0
       (setq f2(open "F:\\统计长度.txt" "a"));打开数据文件
       (setq timenow (menucmd "M=$(edtime,$(getvar,date),YYYY MONTH DD \"日\"HH\":\"MM\":\"SS)"))
       (write-line timenow f2);写入当前时间
       (repeat (sslength ss);重复执行，执行的次数等于所选对象的个数
	 (setq l_s 0 )
         (setq e(ssname  ss  n));得到选择集内第n个对象的图元名
         ;(setq el(entget e));得到这个对象的图元表
	 ;(command "list" e "")
	 ;(command "_lengthen" e "")
	 ;(setq l_s (getvar "perimeter"))
	 (setq ecvla (vlax-ename->vla-object e));将visual lisp 类型转换为vla对象
	 (setq l_s (vlax-curve-getdistatparam ecvla (vlax-curve-getendparam ecvla)));返回长度
	 (setq  l_t (+ l_s l_t))
         (setq  att_txt (strcat  (itoa (1+ n)) '"\-" (rtos l_s) "\-" (rtos l_t) ));取序号-单长-总长
         (write-line att_txt f2);写入内容
         (setq n(1+ n)) ;序号n的数量加1
       )
       (close f2)
       (PRINC att_txt)(PRINC)
     )
     
   )
   
)