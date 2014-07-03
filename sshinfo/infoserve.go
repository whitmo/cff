package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
	"net/http"
)

type Handler struct{
	container string
}

func (handler *Handler) doit(w http.ResponseWriter, r *http.Request) {
	port := retrieve_port(handler.container, r.URL.Path[1:])
	fmt.Fprint(w, port)
}


func main() {
	args := os.Args[1:]
	container := args[0]
	handler := &Handler{container:container}
	http.HandleFunc("/", handler.doit)
	http.ListenAndServe(":8080", nil)
}



func retrieve_port(container string, port string) string{
	cmd := fmt.Sprintf("docker port %s %s", container, port)
	portcmd := exec.Command("/bin/bash", "-c", cmd)
	portout, err := portcmd.CombinedOutput()
	if err != nil {
		fmt.Println(string(portout))
	}
	out := strings.SplitN(string(portout), ":", 2)
	return out[1]
}
