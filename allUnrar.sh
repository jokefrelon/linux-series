#/bin/ash
cd /mnt/Personal/RaR
num=2
echo $num
for er in `ls`
do
	        echo "Start????????????????????????"
		        cd /mnt/Personal/RaR
			        se="xyxgj"$num
				        echo $se "~~~~~~~~~~~~~~~~"
					        cd /mnt/Personal/BeautyPics
						        haha=`pwd`"/"$se
							        echo $haha "||||||||||||||"
								        cd /mnt/Personal/RaR
									        pwd
										        unrar e $er $haha
											        let "num++"
												        echo $num
													        echo "end~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
													done
													echo "Unrar successful !"
