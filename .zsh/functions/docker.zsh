
# Docker & Docker-Compose {{{


dkcn() {
    ./docker-compose-env $1
}


docker_redis() {
    docker run --name redis -p 6379:6379 -d redis
}


dkcn_run() {
    dkcn run workspace bash
}


dk_system_prune() {
    if ask "docker system prune"; then
        docker system prune
    fi
}


dkicl() {
    if ask "docker image prune"; then
        docker image prune
    fi
}


docker_rmi() {
    # remove first line
    target=$(
        docker images --no-trunc | tail -n +2
    )
    final=$(
        (echo "$target") |
        # -d HEIGHT, -d Split below, --ansi tells fzf to extract and parse ANSI color codes in the input
        fzf-tmux -d 50% -- --no-hscroll --ansi +m -d "\t" -n 2
    )
    return_code="$?"
    if [ "$return_code" -ne 0 ]; then
         echo "aborted! ($return_code)"
         return "$return_code"
    fi
    # final $1 is REPOSITORY, $3 is IMAGE ID
    if ask "Docker remove images: \n$(echo "$final" | awk '{print $1}')"; then
        echo "$final" | awk '{print $3}' | xargs docker rmi
    fi
}
alias fdkrmi=docker_rmi


docker_list_dangling() {
    docker images -f dangling=true
}


docker_rm_dangling() {
    if ask "Docker remove dangling images: \n$(docker images -f dangling=true)"; then
        docker images -f dangling=true | awk '{print $3}' | xargs docker rmi
    fi
}
alias fdkrmdd=docker_rm_dangling


dkcn_build_gitlab() {
    dkcn build --build-arg GIT_USER=stanliu.caty --build-arg GIT_PASSWORD=qwert111
}


dkc_env_build_quest_api() {
    dkcn build --build-arg AP_ECR_URI='514033784761.dkr.ecr.ap-northeast-1.amazonaws.com/$1-flask-api-quest:latest'
}


awsinfo() {
    docker run -it -v ~/.aws:/root/.aws -e `aws configure get aws_access_key_id` -e `aws configure get aws_secret_key_id` -e `aws configure get region`
}


dk_login_gitlab() {
    echo "docker $cloud logging..."
    docker login -u stanliu7 -p qwert111 registry.gitlab.com
}


dk_login_aws() {
    aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 514033784761.dkr.ecr.ap-northeast-1.amazonaws.com
}


dk_login_aws_quest() {
    aws ecr get-login-password  \
        --profile quest         \
        --region ap-northeast-1 \
        | docker login --username AWS --password-stdin 514033784761.dkr.ecr.ap-northeast-1.amazonaws.com
}


dk_login_aws_orcahub() {
    aws ecr get-login-password  \
        --profile orcahub       \
        --region ap-northeast-1 \
        | docker login --username AWS --password-stdin 788604354292.dkr.ecr.ap-northeast-1.amazonaws.com/api-hub/pkg/for-infra:build-env
}


# }}}

