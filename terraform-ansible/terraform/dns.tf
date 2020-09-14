resource "aws_route53_zone" "poc_zone" {
  name = "poc.com"
}

resource "aws_route53_record" "alb_alias" {
  zone_id = aws_route53_zone.poc_zone.zone_id
  name    = "elb-alias"
  type    = "A"

  alias {
    name                   = aws_lb.alb-poc.dns_name
    zone_id                = aws_lb.alb-poc.zone_id
    evaluate_target_health = true
  }
}
