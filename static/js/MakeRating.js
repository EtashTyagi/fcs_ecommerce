function makePosRating(rating) {
    let pos_rating = "";
    for (let i = 0; i < Math.min(10, parseInt(rating)); i++) {
        pos_rating = pos_rating.concat("⭐")
    }
    return pos_rating
}


function makeNegRating(rating) {
    let neg_rating = "";
    for (let i = 0; i < 10 - parseInt(rating); i++) {
        neg_rating = neg_rating.concat("☆")
    }
    return neg_rating
}