
proj:=demo
export

test:
	make rm; make run; make stage; make weight
run:
	@echo "\n Create Demo Servces \n"; 
	rio run -n $$proj -p 80:8080 amitkarpe/demo:black
	sleep 10;
#	for i in blue red yellow green;	do \
#		rio run -n $$proj@$$i -p 80:8080 amitkarpe/demo:$$i; \
#		sleep 2; \
#	done
	rio weight demo@v0=1
	sleep 2;
	#rio rm demo@v0;

stage:
	for i in  blue red yellow green ;	do \
		rio stage --image amitkarpe/demo:$$i $$proj@v0 $$i; \
	done
	#rio weight $$proj@$$i=25; \

weight:
	rio weight demo@v0=2 | true
	#rio weight demo=100 | true
	echo "\n Weight Demo Servces \n";
	sleep 2;
	for i in  blue red yellow green ;	do \
		rio weight $$proj@$$i=25 |true;  \
	done
	#rio weight demo=20
	
rm:
	@echo "\n Remove Demo Servces \n"; 
	for i in blue red yellow green ;	do \
		rio rm $$proj@$$i; \
	done
	rio rm $$proj  | true
	rio rm $$proj@v0 | true
	sleep 5;

