;��ͳ�Ƴ��ȡ�

(defun c:tjcd(/  pt1 pt2 ss e  el n f2 attlist att_txt l_s l_t ecvla timenow)

   (vl-load-com)
   
   (setq pt1 (getpoint "��ѡ��ͼ�����Ͻ�:\n"))
   (setq pt2 (getcorner pt1 "��ѡ��ͼ�����½�:\n"))
   (PRINC "\nͳ�Ƴ��ȣ���������ϵ:��ɣ�18919611085�� \n")(PRINC)
   
   (setq l_s 0 l_t 0)
   ;(setq ss (ssget "_W" pt1 pt2  '((0 . "insert" ))))
   (setq ss (ssget "_W" pt1 pt2  ))
   (if (/= ss nil) 
     (progn
       (setq n 0) ;��ŵĳ�ֵΪ0
       (setq f2(open "F:\\ͳ�Ƴ���.txt" "a"));�������ļ�
       (setq timenow (menucmd "M=$(edtime,$(getvar,date),YYYY MONTH DD \"��\"HH\":\"MM\":\"SS)"))
       (write-line timenow f2);д�뵱ǰʱ��
       (repeat (sslength ss);�ظ�ִ�У�ִ�еĴ���������ѡ����ĸ���
	 (setq l_s 0 )
         (setq e(ssname  ss  n));�õ�ѡ���ڵ�n�������ͼԪ��
         ;(setq el(entget e));�õ���������ͼԪ��
	 ;(command "list" e "")
	 ;(command "_lengthen" e "")
	 ;(setq l_s (getvar "perimeter"))
	 (setq ecvla (vlax-ename->vla-object e));��visual lisp ����ת��Ϊvla����
	 (setq l_s (vlax-curve-getdistatparam ecvla (vlax-curve-getendparam ecvla)));���س���
	 (setq  l_t (+ l_s l_t))
         (setq  att_txt (strcat  (itoa (1+ n)) '"\-" (rtos l_s) "\-" (rtos l_t) ));ȡ���-����-�ܳ�
         (write-line att_txt f2);д������
         (setq n(1+ n)) ;���n��������1
       )
       (close f2)
       (PRINC att_txt)(PRINC)
     )
     
   )
   
)