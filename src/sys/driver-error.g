;M25
echo "Driver error on drive "^{param.D}^""
;M291 R"Motor Error" P"Position tolerance exceeded on drive - rehome machine in XY to resume printing" S3
;if input == 0
;    M0
;elif input == 1
;    G28 XY
;    T R1
;    M24
