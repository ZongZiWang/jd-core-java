OS=macosx
VERSION=x86_64
ARCH=$(OS)/$(VERSION)

ifeq ($(OS),linux)
	shared=libjd-intellij.so
else
	ifeq ($(OS), macosx)
		shared=libjd-intellij.jnilib
	else
		shared=libjd-intellij.dll
	endif
endif

all: jd-core-java-1.0.jar $(shared)

jd-intellij:
	hg clone https://bitbucket.org/bric3/jd-intellij

$(shared): jd-intellij
	cp jd-intellij/src/main/native/nativelib/${ARCH}/${shared} .

target/jd-core-java-1.0.jar:
	mvn package

jd-core-java-1.0.jar: target/jd-core-java-1.0.jar
	cp $< $@

clean:
	rm -rf jd-core-java-1.0.jar ${shared} target jd-intellij

clean-objects:
	rm -rf jd-core-java-1.0.jar ${shared} target
