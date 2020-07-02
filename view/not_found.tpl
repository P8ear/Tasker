<?php echo $header; ?>
<content>
	<div class="container">
		<ul class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
		<?php } ?>
		</ul>
		<div class="row">
			<div class="col-sm-12">
				<div class="p404 text-center">
				<?php echo $text_error; ?>
				</div>
			</div>
		</div>
	</div>
</content>
<?php echo $footer; ?>