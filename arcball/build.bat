
javac -cp ../../lib/core.jar; -sourcepath src -d classes -target 1.1 -source 1.3 src/com/processinghacks/arcball/*.java

@cd classes
jar -Mcvf ../library/arcball.jar com/processinghacks/arcball/*.class 
@cd ..
