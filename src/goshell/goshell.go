package main

import (
	"net/http"
	"os/exec"
	"log"
	"fmt"
)

func exeshell(w http.ResponseWriter,  r *http.Request) {

	cmd := exec.Command("./goshell.sh")
	out, err := cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("cmd.Run() failed with %s\n", err)
	}
	fmt.Fprintf(w, string(out))

}


func main() {
	http.HandleFunc("/", exeshell)
	if err := http.ListenAndServe(":8090", nil); err != nil {
		panic(err)
	}
}