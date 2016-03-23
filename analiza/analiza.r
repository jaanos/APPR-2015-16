# 4. faza: Analiza podatkov




max_y <- max(OK.obiskovalci)


plot_colors <- c("blue","red","darkgreen","black","gray20","gold","darkmagenta","darkorange","brown","deeppink","chocolate","cyan")


plot(OK.obiskovalci$Pomurska, type="o", col=plot_colors[1], 
     ylim=c(0,max_y), axes=FALSE, ann=FALSE)


axis(1, at=1:6, lab=c("2007", "2008", "2009", "2010", "2013", "2014"))


axis(2, las=1, at=1000*0:max_y)


#box()

lines(OK.obiskovalci$Podravska, type="o", col=plot_colors[2])


lines(OK.obiskovalci$Koroška, type="o", col=plot_colors[3])
lines(OK.obiskovalci$Savinjska, type="o", col=plot_colors[4])
lines(OK.obiskovalci$Zasavska, type="o", col=plot_colors[5])
lines(OK.obiskovalci$Spodnjeposavska, type = "o", col=plot_colors[6])
lines(OK.obiskovalci$Jugovzhodna, type ="o", col=plot_colors[7])
lines(OK.obiskovalci$Osrednjeslovenska, type ="o", col=plot_colors[8])
lines(OK.obiskovalci$Gorenjska, type = "o", col=plot_colors[9])
lines(OK.obiskovalci$Notranjsko.kraška,type="o", col=plot_colors[10])
lines(OK.obiskovalci$Goriška,type = "o", col=plot_colors[11])
lines(OK.obiskovalci$Obalno.kraška, type="o", col=plot_colors[12])

title(main="Obiskovalci", col.main="red", font.main=4)


title(xlab= "Leta", col.lab=rgb(0,0.5,0))
title(ylab= "Skupaj", col.lab=rgb(0,0.5,0))


#legend("right",names(OK.obiskovalci), cex=0.8, col=plot_colors, pch=20:27, lty=1:20, xjust=0.5);
