<?php 
	$access_token = 'EAARieRByxxUBAJsRE4ckg5rHLffjO1MSw1i3cIOFSJWyw0phlW37yj8QmNFXuLLQH1z6Fny6uA5RtSi9TqZBZAZAusF9Pf0ZCZBUanmMOZCPziEBUTa95YcEhMUIxIuuIdgV9f0RAGytQSKjvigZB06';
	if(isset($_GET["id"]))
	{
		if($_GET["detailName"]=='event')
		{
			$url = "https://graph.facebook.com/v2.8/".$_GET['id']."?fields=name&access_token=".$access_token;
			$result = file_get_contents($url);
			echo $result;
		}
		else
		{
			if($_GET["detailType"]=='album')
			{
				$url = "https://graph.facebook.com/v2.8/".$_GET['id']."?fields=albums.limit(5){name,photos.limit(2){name,picture.width(700).height(700)}},name&access_token=".$access_token;
				$result = file_get_contents($url);
				echo $result;
			}
			else
			{
				$url = "https://graph.facebook.com/v2.8/".$_GET['id']."?fields=posts.limit(5){message,created_time},name&access_token=".$access_token;
				$result = file_get_contents($url);
				echo $result;
			}
			
		}
		
	}
	if(isset($_GET["picture"]))
	{
		$url = "https://graph.facebook.com/v2.8/".$_GET['picture']."/picture?redirect=false&access_token=".$access_token;
		$result = file_get_contents($url);
			echo $result;
	}
	if(isset($_GET["type"]))
	{
		if($_GET["type"]=="user")
		{
			$url = "https://graph.facebook.com/v2.8/search?q=".$_GET['q']."&type=user&fields=id,name,picture.width(300).height(300)&access_token=".$access_token;
			$result = file_get_contents($url);
			echo $result;
		}
		elseif($_GET["type"]=="page")
		{
			$url = "https://graph.facebook.com/v2.8/search?q=".$_GET['q']."&type=page&fields=id,name,picture.width(300).height(300)&access_token=".$access_token;
			$result = file_get_contents($url);
			echo $result;
		}
		elseif($_GET["type"]=="event")
		{
			$url = "https://graph.facebook.com/v2.8/search?q=".$_GET['q']."&type=event&fields=id,name,picture.width(300).height(300)&access_token=".$access_token;
			$result = file_get_contents($url);
			echo $result;
		}
		elseif($_GET["type"]=="place")
		{
			
			$url = "https://graph.facebook.com/v2.8/search?q=".$_GET['q']."&type=place&fields=id,name,picture.width(300).height(300)&access_token=".$access_token;
			$result = file_get_contents($url);
			echo $result;
		}
		else
		{
			$url = "https://graph.facebook.com/v2.8/search?q=".$_GET['q']."&type=group&fields=id,name,picture.width(300).height(300)&access_token=".$access_token;
			$result = file_get_contents($url);
			echo $result;
		}
	}
?>